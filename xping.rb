class Xping < Formula
  homepage "https://github.com/martintopholm/xping"

  depends_on "libevent"

  stable do
    url "https://github.com/martintopholm/xping/archive/v1.3.1.tar.gz"
    sha256 "0d2ce17ab3d2d6b205c2bb003552e1112b028ba79c2c2cdd067383828cc939cc"
  end

  head do
    url "https://github.com/martintopholm/xping.git", :branch => "master"
  end

  def install
    # Terminal.app doesn't play well with ANSI sequences.
    # Link against NCURSES instead.
    ENV.append "DEPS", "check-curses.c"
    ENV.append "CFLAGS", "-DNCURSES"
    ENV.append "LIBS", "-lncurses"
    system "make"
    system "make", "install", "BINPATH=#{bin}", "MANPATH=#{man}"
  end

  test do
    # Non-setuid xping can't open raw socket and will return error.
    # Request version string instead.
    system "#{bin}/xping", "-V"
  end

  def caveats; <<-EOS.undent
    xping requires root privileges so you will need to run `sudo xping`.
    You should be certain that you trust any software you grant root privileges.
    EOS
  end
end
