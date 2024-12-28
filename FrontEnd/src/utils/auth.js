export const getTokenFromLS = () => {
  return localStorage.getItem('token')
}

export const setTokenToLS = (token) => {
  localStorage.setItem('token', token)
}

export const getRoleFromLS = () => {
  return localStorage.getItem('role')
}

export const setRoleToLS = (role) => {
  localStorage.setItem('role', role)
}

export const clearLS = () => {
  localStorage.removeItem('token')
}