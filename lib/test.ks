@lazyglobal off.

function assert {
  parameter value.
  parameter equality is true.
  parameter description is "".

  if not value = equality {
    print "Failed: " + value + " : " + description.
  } else {
    print "Succeeded: " + value + " : " + description.
  }
}