import { Box } from '@mui/material'
import { NavLink } from 'react-router-dom'
import DashboardIcon from '@mui/icons-material/Dashboard'
import ReceiptIcon from '@mui/icons-material/Receipt';

export default function SideBar() {
  return (
    <Box
      position='fixed'
      width='12rem'
      height={'calc(100vh - 64px)'}
      p={2}
      boxSizing={'border-box'}
      display={'flex'}
      flexDirection='column'
      gap={1}
    >
      <NavLink
        to='/'
        style={({isActive}) => ({
          display: 'flex',
          justifyContent: 'space-between',
          textDecoration: 'none',
          color: isActive ? '#f73378' : 'lightgray',
          backgroundColor: isActive? 'rgba(247, 51, 120, 0.1)' : '',
          padding: '0.5rem',
          borderRadius: '4px'
        })}
      >
        <DashboardIcon />
        Dashboard
      </NavLink>

      <NavLink
        to='/invoice'
        style={({isActive}) => ({
          display: 'flex',
          justifyContent: 'space-between',
          textDecoration: 'none',
          color: isActive ? '#f73378' : 'lightgray',
          backgroundColor: isActive? 'rgba(247, 51, 120, 0.2)' : 'transparent',
          padding: '0.5rem',
          borderRadius: '4px'
        })}
      >
        <ReceiptIcon />
        Invoice
      </NavLink>
    </Box>
  )
}
