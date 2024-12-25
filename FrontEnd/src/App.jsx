import { createTheme, ThemeProvider } from '@mui/material'
import MainLayout from './layouts/MainLayout'
import { deepPurple, pink } from '@mui/material/colors'

function App() {
  const theme = createTheme({
    palette: {
      primary: pink,
      secondary: deepPurple
    }
  })
  return (
    <ThemeProvider theme={theme}>
      <MainLayout></MainLayout>
    </ThemeProvider>
  )
}

export default App
