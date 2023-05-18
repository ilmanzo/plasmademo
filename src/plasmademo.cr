# adapted from C source at https://gist.github.com/stevenlr/824019

require "raylib-cr"

# our window size
SCREEN_WIDTH  = 640
SCREEN_HEIGHT = 480

# our palette
colortable = StaticArray(Raylib::Color, 256).new { |x|
  r = 255 - ((Math.sin(Math::TAU * x / 255) + 1) * 127).ceil
  g = ((Math.sin(Math::TAU * x / 127.0) + 1) * 64).ceil
  b = 255 - r
  Raylib::Color.new r: r.to_u8, g: g.to_u8, b: b.to_u8, a: 255
}

Raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "Plasma")
Raylib.set_target_fps(60)

f = 0.0
until Raylib.close_window?
  Raylib.begin_drawing
  (0...SCREEN_HEIGHT).each do |y|
    (0...SCREEN_WIDTH).each do |x|
      c1 = Math.sin(x / 50.0 + f + y / 200.0)
      c2 = Math.sqrt((Math.sin(0.8 * f) * 160 - x + 160) * (Math.sin(0.8 * f) * 160 - x + 160) +
                     (Math.cos(1.2 * f) * 100 - y + 100) * (Math.cos(1.2 * f) * 100 - y + 100))
      c2 = Math.sin(c2 / 50.0)
      c3 = (c1 + c2) / 2
      res = ((c3 + 1) * 127).ceil.to_u8
      Raylib.draw_pixel(x, y, colortable[res])
    end
  end
  Raylib.end_drawing
  f += 0.1
end

Raylib.close_window
