class ParseSideResult
{

public:
  bool Success;
  int Side;
  string ErrorMessage;
  ParseSideResult(int side)
  {
    Side = side;
    Success = true;
  }

  ParseSideResult(string errorMessage)
  {
    ErrorMessage = errorMessage;
    Success = false;
  }
};