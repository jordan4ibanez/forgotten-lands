namespace utility {
    // Taken from: https://gist.github.com/lopspower/03fb1cc0ac9f32ef38f4 (Thanks lopspower & LeoMacherla!)
    // Written into this abomination.

    export const hexValues: { [id: number]: string; } = {
        100: "FF",
        99: "FC",
        98: "FA",
        97: "F7",
        96: "F5",
        95: "F2",
        94: "F0",
        93: "ED",
        92: "EB",
        91: "E8",
        90: "E6",
        89: "E3",
        88: "E0",
        87: "DE",
        86: "DB",
        85: "D9",
        84: "D6",
        83: "D4",
        82: "D1",
        81: "CF",
        80: "CC",
        79: "C9",
        78: "C7",
        77: "C4",
        76: "C2",
        75: "BF",
        74: "BD",
        73: "BA",
        72: "B8",
        71: "B5",
        70: "B3",
        69: "B0",
        68: "AD",
        67: "AB",
        66: "A8",
        65: "A6",
        64: "A3",
        63: "A1",
        62: "9E",
        61: "9C",
        60: "99",
        59: "96",
        58: "94",
        57: "91",
        56: "8F",
        55: "8C",
        54: "8A",
        53: "87",
        52: "85",
        51: "82",
        50: "80",
        49: "7D",
        48: "7A",
        47: "78",
        46: "75",
        45: "73",
        44: "70",
        43: "6E",
        42: "6B",
        41: "69",
        40: "66",
        39: "63",
        38: "61",
        37: "5E",
        36: "5C",
        35: "59",
        34: "57",
        33: "54",
        32: "52",
        31: "4F",
        30: "4D",
        29: "4A",
        28: "47",
        27: "45",
        26: "42",
        25: "40",
        24: "3D",
        23: "3B",
        22: "38",
        21: "36",
        20: "33",
        19: "30",
        18: "2E",
        17: "2B",
        16: "29",
        15: "26",
        14: "24",
        13: "21",
        12: "1F",
        11: "1C",
        10: "1A",
        9: "17",
        8: "14",
        7: "12",
        6: "0F",
        5: "0D",
        4: "0A",
        3: "08",
        2: "05",
        1: "03",
        0: "00"
    };

    export function lockChannel(input: number): number {
        return math.floor(math.clamp(0, 100, input));
    }

    /**
     * Get the alpha level of a number. (Integers only)
     * @param input Integral percent. (0-100)
     * @returns Alpha AA string to bolt onto a color hex.
     */
    export function percentToAlphaHex(input: number): string {
        const clamped = lockChannel(input);
        return hexValues[clamped];
    }

    export function color(r: number, g: number, b: number, a?: number): string {
        let newColor = "#";
        for (const channel of [r, g, b, a]) {
            if (channel) {
                newColor += hexValues[lockChannel(channel)];
            }
        }
        return newColor;
    }

    /**
     * Like the color() function, but can take in raw (0-255) rgba elements.
     * @param r Red channel. (0-255)
     * @param g Green channel. (0-255)
     * @param b Blue channel. (0-255)
     * @param a Alpha channel. (0-255)
     * @returns Color string in hex.
     */
    export function colorRGB(r: number, g: number, b: number, a?: number): string {
        // Get everything to 0-100 range
        a = (a) ? a / 2.55 : a;
        return color(r / 2.55, g / 2.55, b / 2.55, a);
    }

    export function colorScalar(s: number, a?: number): string {
        let newColor = "#";
        const hex = hexValues[lockChannel(s)];
        for (let i = 0; i < 3; i++) {
            newColor += hex;
        }
        if (a) {
            newColor += hexValues[lockChannel(a)];
        }
        return newColor;
    }

}