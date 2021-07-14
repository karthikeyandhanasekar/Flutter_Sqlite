emailvalidator(String value)
{
  if (value.isEmpty)
  {
    return "Required";
  }
  else if(!value.contains('@'))
  {
    return "Invalid Email";
  }
  else
  {
    return null;
  }
}

phonevalidator(String value)
{
  if (value.isEmpty)
  {
    return "Required";
  }
  else if(value.length == 10)
  {
    return "Invalid PhoneNumber";
  }
  else
  {
    return null;
  }
}
zipcode(String value)
{
  if (value.isEmpty)
  {
    return "Required";
  }
  else if(value.length == 6)
  {
    return "Invalid ZipCode";
  }
  else
  {
    return null;
  }
}