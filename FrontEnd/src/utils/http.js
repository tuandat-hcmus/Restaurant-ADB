import axios from 'axios'
import { getTokenFromLS } from './auth'
export class Http {
  constructor() {
    this.instance = axios.create({
      baseURL: 'http://localhost:8080/',
      timeout: 10000
    })
    this.token = getTokenFromLS()
    this.instance.interceptors.request.use(
      (config) => {
        if (this.token) {
          config.headers.Authorization = `Bearer ${this.token}`
        }
        return config
      },
      (error) => {
        return Promise.reject(error)
      }
    )
    this.instance.interceptors.response.use(
      (config) => config.data,
      (error) => {
        return Promise.reject(error)
      }
    )
  }
  get = (url) => {
    return this.instance.get(url)
  }
  post = (url, body) => {
    return this.instance.post(url, body)
  }
}

export const http = new Http().instance
