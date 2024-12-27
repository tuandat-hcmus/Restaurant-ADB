import { http } from "src/utils/http"
import {jwtDecode} from 'jwt-decode'

const authApi = {
  registerAcount: (body) => {
    return http.post('/register', body)
  }, 
  login: (body) => {
    return http.post('login', body).then((config) => {
      const data = jwtDecode(config.token)
      return data
    })
  }, 
  cusRegisterAccount: (body) => {
    return http.post('cusRegister', body)
  }, 
  cusLogin: (body) => {
    return http.post('cusLogin', body).then((config) => {
      const data = jwtDecode(config.token)
      return data
    })
  },
  logout: () => {
    
  }
}
export default authApi