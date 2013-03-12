require 'erb'
layout 'layout.html.erb'
ignore /Gemfile.*/
ignore /.+.md/

helpers do
  # This came from Nanoc
  # http://nanoc.ws/docs/api/Nanoc/Helpers/Capturing.html#capture-instance_method
  def capture(&block)
    # Get erbout so far
    erbout = eval('_erbout', block.binding)
    erbout_length = erbout.length

    # Execute block
    block.call

    # Get new piece of erbout
    erbout_addition = erbout[erbout_length..-1]

    # Remove addition
    erbout[erbout_length..-1] = ''

    # Depending on how the filter outputs, the result might be a
    # single string or an array of strings (slim outputs the latter).
    erbout_addition = erbout_addition.join if erbout_addition.is_a? Array

    # Done.
    erbout_addition
  end

  def code_block(&block)
    b = block.binding
    output = capture(&block)
    o = "<div class='test-wrapper'>#{output}</div>"
    ERB.new(o, nil, nil).result(block.binding)
  end
end
