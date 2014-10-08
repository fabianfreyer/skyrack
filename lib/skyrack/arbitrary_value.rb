#!/usr/bin/env ruby

def set_reg(val)
  res = [:init_zero]

  # MSB to LSB
  val.to_s(2).each_byte do |b|
    res << :inc if b.chr == '1'
    res << :double
  end
  res.pop
  res
end

def compute_reg(val)
  res = nil
  val.each do |op|
    case op
    when :init_zero
      res = 0
    when :inc
      res += 1
    when :double
      res <<= 1
    else
      raise "unknown op %s" % op
    end
  end
  res
end

if $0 == __FILE__
  val = ARGV[0].to_i
  puts "converting %d" % val
  list_ops = set_reg(val)
  puts list_ops.inspect, "=", compute_reg(list_ops)
end
