import { createContext, useEffect, useState } from 'react'

const initialAppContext = {
  isAuthenticated: false, 
  setIsAuthenticated: () => {}
}

export const AppContext = createContext(initialAppContext)

export const AppProvider = ({children, defaultValue = initialAppContext}) => {
  const [isAuthenticated, setIsAuthenticated] = useState(defaultValue.isAuthenticated)
  useEffect(() => {
    console.log(isAuthenticated)
  }, [isAuthenticated])
  return (
    <AppContext.Provider value={{
      isAuthenticated,
      setIsAuthenticated
    }}>
      {children}
    </AppContext.Provider>
  )
}
