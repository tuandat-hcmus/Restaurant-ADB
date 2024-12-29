import { getTokenFromLS } from '../utils/auth'
import { jwtDecode } from 'jwt-decode'
import { http } from 'src/utils/http'

const EMP_URL = ''

const userApi = {
  getUserId: () => {
    const token = getTokenFromLS()
    const { userId } = jwtDecode(token)
    return userId
  },
  getEmpInfo: (empId) => {
    return http.get(`${EMP_URL}/${empId}`)
  }
}
export default userApi
