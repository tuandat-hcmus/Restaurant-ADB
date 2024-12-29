import { createContext, useEffect, useState } from 'react'
import { getRoleFromLS, getTokenFromLS } from '../utils/auth'

const initAppContext = () =>  ({
  isAuth: Boolean(getTokenFromLS()), 
  role: getRoleFromLS(),
  setIsAuth: () => {},
  setIsCusAuth: () => {}
})

const initialAppContext = initAppContext()

export const AppContext = createContext(initialAppContext)

export const AppProvider = ({children, defaultValue = initialAppContext}) => {
  const [isAuth, setIsAuth] = useState(defaultValue.isAuth)
  const [role, setRole] = useState(defaultValue.role)
  useEffect(() => {
    console.log(isAuth, role)
  }, [isAuth, role])
  return (
    <AppContext.Provider value={{
        isAuth, 
        role, 
        setIsAuth, 
        setRole
    }}>
      {children}
    </AppContext.Provider>
  )
}
