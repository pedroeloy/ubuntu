#!/usr/bin/env python3
import argparse
import subprocess
import sys

# Reference curve from your example, assumed to correspond to:
# 1000 DPI, 150% GNOME and Windows scaling, Windows speed 10/20.
BASE_CURVE = [0.0, 0.3, 0.5, 0.75, 1.0, 1.5, 2.27]
POINTER_STEP = 0.5

def main():
    parser = argparse.ArgumentParser(
        description="Generate an approximate GNOME custom mouse acceleration curve."
    )
    parser.add_argument("--dpi", type=float, required=True, help="Mouse DPI")
    parser.add_argument("--gnome-scale", type=float, required=True,
                        help="GNOME display scale, e.g. 150 for 150%%")
    parser.add_argument("--windows-scale", type=float,
                        help="Windows display scale; defaults to GNOME scale")
    parser.add_argument("--windows-speed", type=int, required=True,
                        help="Windows pointer-speed position, 1–20")
    parser.add_argument("--epp", choices=("on", "off"), default="on",
                        help="Enhance pointer precision; default: on")
    parser.add_argument("--apply", action="store_true",
                        help="Apply the generated value with gsettings")
    args = parser.parse_args()

    if args.dpi <= 0 or args.gnome_scale <= 0:
        parser.error("DPI and GNOME scale must be greater than zero")
    if not 1 <= args.windows_speed <= 20:
        parser.error("--windows-speed must be between 1 and 20")

    windows_scale = args.windows_scale or args.gnome_scale

    # Heuristic only: assumes Windows speed 10 is the reference midpoint.
    slider_gain = 2 ** ((args.windows_speed - 10) / 10)

    # Compensate approximately for mouse DPI and the ratio of display scales.
    display_and_dpi_gain = (1000 / args.dpi) * (
        args.gnome_scale / windows_scale
    )
    gain = slider_gain * display_and_dpi_gain

    if args.epp == "on":
        speeds = [round(value * gain, 4) for value in BASE_CURVE]
    else:
        # Approximate no acceleration with a constant response.
        speeds = [round(gain, 4)] * len(BASE_CURVE)

    speed_list = ", ".join(f"{value:.4f}" for value in speeds)
    variant = (
        "{'pointer-step': <0.5>, "
        f"'pointer-speeds': <[{speed_list}]>}}"
    )

    if args.apply:
        result = subprocess.run(
            [
                "gsettings", "set",
                "org.gnome.desktop.peripherals.mouse",
                "custom-accel-config", variant,
            ],
            text=True,
            capture_output=True,
        )
        if result.returncode:
            print(result.stderr.strip(), file=sys.stderr)
            sys.exit(result.returncode)
        print("Applied custom-accel-config.")
    else:
        print(variant)
        print("\nReview the value, then rerun with --apply to set it.")

if __name__ == "__main__":
    main()
