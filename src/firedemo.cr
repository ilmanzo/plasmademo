require "raylib-cr"

# our window size
SCREEN_WIDTH  = 800
SCREEN_HEIGHT = 350

# our palette
colortable = StaticArray(Raylib::Color, 256).new { |x|
  r = x
  g = x<127 ? 0 : 256-x
  b = 16
  Raylib::Color.new r: r.to_u8, g: g.to_u8, b: b.to_u8, a: 255
}

pixelbuffer = Array.new(SCREEN_WIDTH*SCREEN_HEIGHT, 0)

Raylib.init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "Fire effect")
Raylib.set_target_fps(60)

until Raylib.close_window?
  (0...SCREEN_WIDTH).each do |x|
    pixelbuffer[x + (SCREEN_HEIGHT - 1)*SCREEN_WIDTH] = rand(256)
  end
  (0...SCREEN_HEIGHT).each do |y|
    y_ofs = ((y + 1) % SCREEN_HEIGHT)*SCREEN_WIDTH
    (0...SCREEN_WIDTH).each do |x|
      a = y_ofs + ((x - 1 + SCREEN_WIDTH) % SCREEN_WIDTH)
      b = y_ofs + (x % SCREEN_WIDTH)
      c = y_ofs + ((x + 1) % SCREEN_WIDTH)
      d = ((y + 2) % SCREEN_HEIGHT)*SCREEN_WIDTH + (x % SCREEN_WIDTH)
      pixelbuffer[y*SCREEN_WIDTH + x] = (pixelbuffer[a] + pixelbuffer[b] + pixelbuffer[c] + pixelbuffer[d])*256//1025
    end
  end
  Raylib.begin_drawing
  (0...SCREEN_HEIGHT).each do |y|
    (0...SCREEN_WIDTH).each do |x|
      pixel = pixelbuffer[y*SCREEN_WIDTH + x]
      Raylib.draw_pixel(x, y, colortable[pixel])
    end
  end
  Raylib.end_drawing
end

Raylib.close_window
