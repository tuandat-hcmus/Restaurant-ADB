import { createTheme, ThemeProvider } from '@mui/material'
import useRouteElements from './useCustomeRoutes'
import { deepPurple, pink } from '@mui/material/colors'


function App() {
  const theme = createTheme({
    palette: {
      primary: pink,
      secondary: deepPurple
    }
  })
  const elements = useRouteElements()
  return (
    <ThemeProvider theme={theme}>
      {elements} 
    </ThemeProvider>
  )
}

export default App
