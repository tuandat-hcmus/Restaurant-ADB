import { http } from 'src/utils/http'
import { clearLS } from 'src/utils/auth'

const authApi = {
  registerAcount: (body) => {
    return http.post('/register', body)
  },
  login: (body) => {
    return http.post('login', body)
  },
  cusRegisterAccount: (body) => {
    return http.post('cusRegister', body)
  },
  cusLogin: (body) => {
    return http.post('cusLogin', body)
  },
  logout: () => {
    clearLS()
  }
}
export default authApi
