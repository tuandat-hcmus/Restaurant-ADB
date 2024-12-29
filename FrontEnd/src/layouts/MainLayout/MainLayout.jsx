import { Box } from '@mui/material'
import { Outlet } from 'react-router-dom'
import TopBar from 'src/components/TopBar'

export default function MainLayout() {
  return (
    <main>
      <TopBar />
      <Box mx={14} my={4}>
        <Outlet />
      </Box>
    </main>
  )
}
