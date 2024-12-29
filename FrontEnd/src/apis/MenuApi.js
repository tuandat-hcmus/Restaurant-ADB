import { http } from 'src/utils/http'

const URL = 'thucdon'
const menuApi = {
  getMenu: (branchId) => {
    return http.get(`${URL}/${branchId}`)
  }
}

export default menuApi
