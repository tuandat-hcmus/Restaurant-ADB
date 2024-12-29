import {http} from 'src/utils/http'
const URL = 'phieudat'
const orderApi = {
  getAllOrder : () => {
    return http.get(`${URL}/all`)
  },
  insertOrder: (orderList) => {
    return http.post(`${URL}/them`, orderList)
  }
}

export default orderApi