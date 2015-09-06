#!/usr/bin/env ruby
require 'pp'
require 'yaml'

class Fixnum
  ADDITIVE_BITMASKS = (0..6).map { |n| 1 << n }
  REMOVAL_BITMASKS = ADDITIVE_BITMASKS.map(&:~)

  def to_7sd
    case self
    when 0; 0x7E
      when 1; 0x30
      when 2; 0x6D
      when 3; 0x79
      when 4; 0x33
      when 5; 0x5B
      when 6; 0x5F
      when 7; 0x70
      when 8; 0x7F
      when 9; 0x7B
      else; nil
    end
  end

  def from_7sd
    case self
    when 0x7E; 0
      when 0x30; 1
      when 0x6D; 2
      when 0x79; 3
      when 0x33; 4
      when 0x5B; 5
      when 0x5F; 6
      when 0x70; 7
      when 0x7F; 8
      when 0x7B; 9
      else; nil
    end
  end

  def remove_7sd_segment
    one_removed = REMOVAL_BITMASKS.map { |b| self.to_7sd & b }
    valid_numbers = one_removed.select(&:valid_7sd?).map(&:from_7sd).select { |n| self != n }
    valid_numbers.map(&:to_s)
  end

  def add_7sd_segment
    one_added = ADDITIVE_BITMASKS.map { |b| self.to_7sd | b }
    valid_numbers = one_added.select(&:valid_7sd?).map(&:from_7sd).select { |n| self != n }
    valid_numbers.map(&:to_s)
  end

  def valid_7sd?
    !from_7sd.nil?
  end
end

input = '1234'
pp input.chars.map(&:to_i)

pp (0..9).map(&:remove_7sd_segment)
pp (0..9).map(&:add_7sd_segment)
