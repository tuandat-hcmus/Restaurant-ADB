import { createTheme, ThemeProvider } from '@mui/material'
import MainLayout from './layouts/MainLayout'
import { deepPurple, pink } from '@mui/material/colors'
import {useRoutes} from 'react-router-dom'
import Home from './pages/Home'
import Login from './pages/Login'

function App() {
  const elements = useRoutes(
    [
      {
        path: '/',
        element: <Home />
      }, 
      {
        path: '/login', 
        element: <Login />
      }
    ]
  )
  const theme = createTheme({
    palette: {
      primary: pink,
      secondary: deepPurple
    }
  })
  return (
    <ThemeProvider theme={theme}>
      {elements} 
    </ThemeProvider>
  )
}

export default App
