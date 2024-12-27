export const setTokenToLS = (token) => {
  localStorage.setItem('token', token)
}

export const getTokenFromLS = () => {
  return localStorage.getItem('token')
}

export const clearLS = () => {
  localStorage.removeItem('token')
}