class ApiEndpoints {
  static const baseUrl = "http://192.168.0.146:5000";

  static const requestOtp = "/api/Auth/request-otp";
  static const verifyOtp = "/api/Auth/verify-otp";
  static const register = "/api/Auth/register";
  static const refreshToken = "/api/Auth/refresh-token";
  static const logout = "/api/Auth/logout";
}
