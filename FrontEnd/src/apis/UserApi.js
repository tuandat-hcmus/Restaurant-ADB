import { getTokenFromLS } from '../utils/auth'
import { jwtDecode } from 'jwt-decode'
import { http } from 'src/utils/http'

const EMP_URL = 'emp'

const userApi = {
  getUserId: () => {
    const token = getTokenFromLS()
    if (!token) { return null }
    const { userId } = jwtDecode(token)
    console.log(userId)
    return userId
  },
  getEmpInfo: (empId) => {
    return http.get(`${EMP_URL}/${empId}`)
  }
}
export default userApi
