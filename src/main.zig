const std = @import("std");
const gpio = @import("gpio.zig");
const pins = @import("pins.zig");

pub fn main() void {
    // Onboard LED
    gpio.pinMode(pins.led_builtin, .out);
    // Wired LED
    gpio.pinMode(8, .out);
    // Button
    gpio.pinMode(3, .in);

    var on = false;
    while (true) {
        gpio.toggle(pins.led_builtin);
        if (gpio.digitalRead(3) == .low) {
            gpio.digitalWrite(8, .low);
        } else {
            gpio.digitalWrite(8, .high);
        }
        on = !on;

        // Hard code a busy wait. Will add delays eventually.
        var i: u32 = 0;
        while (i < 100000) : (i += 1) {
            // For some reason need to nop the busy wait
            asm volatile ("nop");
        }
    }
}
