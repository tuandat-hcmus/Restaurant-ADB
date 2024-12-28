export const setCusTokenToLS = (token) => {
  localStorage.setItem('cus_token', token)
}

export const setEmpTokenToLS = (token) => {
  localStorage.setItem('emp_token', token)
}

export const getCusTokenFromLS = () => {
  return localStorage.getItem('cus_token')
}

export const getEmpTokenFromLS = () => {
  return localStorage.getItem('emp_token')
}

export const clearLS = () => {
  localStorage.removeItem('emp_token')
  localStorage.removeItem('cus_token')
}