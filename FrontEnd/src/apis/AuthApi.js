import { http } from "src/utils/http"

const authApi = {
  registerAcount: (body) => {
    return http.post('/register', body)
  }, 
  login: (body) => {
    return http.post('/login', body)
  }, 
  cusRegisterAccount: (body) => {
    return http.post('/cusRegister', body)
  }, 
  cusLogin: (body) => {
    return http.post('/cusLogin', body)
  }
}
export default authApi