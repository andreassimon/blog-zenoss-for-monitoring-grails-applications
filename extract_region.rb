#!/usr/bin/env ruby
quiet = true

$stdin.each_line do |line|
  if !quiet && line =~ / endregion #{ARGV}/
    quiet = true
    if ellipsis = (line.match /endregion multi-machine-setup(.+$)/)
      puts ellipsis[1]
    end
  end
  puts line unless quiet
  if quiet && line =~ / region #{ARGV}/
    quiet = false
  end
end
