require 'pry-byebug'
def correct?(g, s)
  if correct_colors?(g, s)
    correct_index?(g, s)
  else
    false
  end
end

def correct_index?(g, s)
  index_match = []
  s.each_with_index {|val, i|
    s.select {|val|
      if val == g[i]
        index_match.push(g[i])
      end}
  }
  puts index_match
  if (index_match & s) == s
    true
  else
    false
  end
end


def correct_colors?(g, s)
  if (s & g).any?
    puts (s & g)
    true
  else
    false
  end
end

selection = ["a", "b", "c", "d"]
guess = ["a", "b", "d", "c"]
#binding.pry
if correct?(guess, selection)
  puts true
else
  puts false
end