import {
  AppBar,
  Box,
  Button,
  IconButton,
  Menu,
  MenuItem,
  Toolbar,
  Typography,
  ListItemIcon
} from '@mui/material'
import SetMealIcon from '@mui/icons-material/SetMeal'
import Logout from '@mui/icons-material/Logout'
import AccountCircleIcon from '@mui/icons-material/AccountCircle'
import { Link } from 'react-router-dom'
import { useContext, useState } from 'react'
import { AppContext } from 'src/contexts/AppContext'
import authApi from '../../apis/AuthApi'

export default function TopBar() {
  const { isAuth, setIsAuth, setRole } = useContext(AppContext)
  const [anchorEl, setAnchorEl] = useState(null)
  const openMenu = (event) => {
    setAnchorEl(event.target)
  }
  const closeMenu = () => setAnchorEl(null)
  const handleLogout = () => {
    authApi.logout()
    setIsAuth(false)
    setRole(null)
    closeMenu()
  }
  return (
    <AppBar position='relative' sx={{ flexGrow: 1 }}>
      <Toolbar>
        <IconButton sx={{ mr: 1 }} color='inherit' size='large' component={Link} to='/'>
          <SetMealIcon sx={{ scale: 1.5 }} />
        </IconButton>
        <Typography variant='h6' component='div' sx={{ flexGrow: 1, letterSpacing: 2 }}>
          <Box sx={{ fontWeight: 700 }}>ShuShiX</Box>
        </Typography>
        {!isAuth ? (
          <Box gap={2} display='flex'>
            <Button component={Link} to='/login' color='inherit' size='small'>
              Log in as employee
            </Button>
            <Button component={Link} to='/cusLogin' color='inherit' variant='outlined' size='small'>
              Login as customer
            </Button>
          </Box>
        ) : (
          <IconButton sx={{ mr: 1 }} color='inherit' size='large' onClick={openMenu}>
            <AccountCircleIcon sx={{ scale: 1.5 }} />
          </IconButton>
        )}
      </Toolbar>
      <Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={closeMenu}>
        <MenuItem onClick={handleLogout}>
          <ListItemIcon>
            <Logout fontSize='small' />
          </ListItemIcon>
          Logout
        </MenuItem>
      </Menu>
    </AppBar>
  )
}
