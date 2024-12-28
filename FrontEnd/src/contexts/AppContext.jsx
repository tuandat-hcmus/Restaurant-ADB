import { createContext, useEffect, useState } from 'react'

const initialAppContext = {
  isAuth: false, 
  isCusAuth: false, 
  setIsAuth: () => {},
  setIsCusAuth: () => {}
}

export const AppContext = createContext(initialAppContext)

export const AppProvider = ({children, defaultValue = initialAppContext}) => {
  const [isAuth, setIsAuth] = useState(defaultValue.isAuth)
  const [isCusAuth, setIsCusAuth] = useState(defaultValue.isCusAuth)
  useEffect(() => {
    console.log(isAuth)
  }, [isAuth])
  return (
    <AppContext.Provider value={{
        isAuth, 
        isCusAuth, 
        setIsAuth, 
        setIsCusAuth
    }}>
      {children}
    </AppContext.Provider>
  )
}
