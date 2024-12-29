import { http } from 'src/utils/http'

const URL = 'thucdon'
const menuApi = {
  getMenu: (branchId) => {
    http.get(`/${URL}/${branchId}`)
  }
}

export default menuApi
