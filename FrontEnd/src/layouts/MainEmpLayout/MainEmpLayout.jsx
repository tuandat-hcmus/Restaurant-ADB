import { Outlet } from 'react-router-dom'
import TopBar from 'src/components/TopBar'
import { Box } from '@mui/material'
import SideBar from 'src/components/SideBar'

export default function MainEmpLayout() {
  return (
    <div>
      <Box display={'flex'} my={8}>
        <TopBar />
        <SideBar />
        <Box ml={32} mr={4} my={4} flexGrow={1} >
          <Outlet />
        </Box>
      </Box>
    </div>
  )
}
