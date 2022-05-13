#!/usr/bin/env ruby

module Config
  BIT_COUNT = 13
end

module Bit
  ZERO = "0"
  ONE  = "1"
end

def count(lines, value, index)
  return lines.reduce(0) do |sum, line|
    if line[index] == value then
      next sum + 1
    end
    next sum
  end
end

def filter(lines, value, index)
  return lines.select { |line| line[index] == value }
end

def iterate(lines, get_filter_value)
  filtered_lines = lines

  for i in 0..Config::BIT_COUNT-1 do
    if filtered_lines.length() == 1 then
      return filtered_lines[0]
    end

    zero_count = count(filtered_lines, Bit::ZERO, i)
    one_count  = count(filtered_lines, Bit::ONE, i)
    filtered_lines = filter(filtered_lines, get_filter_value.call(zero_count, one_count), i)
  end

  return filtered_lines[0]
end

def bin_to_dec(str)
  return str.to_i(2)
end

def co2_scrubber_rating(lines)
  result = iterate(lines, lambda { |zero_count, one_count| zero_count <= one_count ? Bit::ONE : Bit::ZERO })
  return bin_to_dec(result)
end

def oxygen_generator_rating(lines)
  result = iterate(lines, lambda { |zero_count, one_count| zero_count <= one_count ? Bit::ZERO : Bit::ONE })
  return bin_to_dec(result)
end

lines = []
File.foreach('input.txt') { |x| lines.push(x) }

csr = co2_scrubber_rating(lines)
ogr = oxygen_generator_rating(lines)
lsr = csr * ogr

puts "CO2 Scrubber Rating: #{csr}"
puts "Oxygen Generator rating: #{ogr}"
puts "Life Support Rating: #{lsr}"

