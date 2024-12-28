import { AppBar, Box, Button, IconButton, Toolbar, Typography } from '@mui/material'
import SetMealIcon from '@mui/icons-material/SetMeal'
import AccountCircleIcon from '@mui/icons-material/AccountCircle'
import {Link} from 'react-router-dom'
import { useContext } from 'react'
import { AppContext } from 'src/contexts/AppContext'

export default function TopBar() {
  const {isCusAuth} = useContext(AppContext)
  return (
    <AppBar position='relative' sx={{ flexGrow: 1 }}>
      <Toolbar>
        <IconButton sx={{ mr: 1 }} color='inherit' size='large' component={Link} to='/'>
          <SetMealIcon sx={{ scale: 1.5 }} />
        </IconButton>
        <Typography variant='h6' component='div' sx={{ flexGrow: 1, letterSpacing: 2 }}>
          <Box sx={{ fontWeight: 700 }}>ShuShiX</Box>
        </Typography>
        {!isCusAuth ? 
        <Box gap={2} display='flex'>
          <Button component={Link} to='/login' color='inherit' size='small'>Log in as employee</Button>
          <Button component={Link} to='/cusLogin' color='inherit' variant='outlined' size='small'>Login as customer</Button> 
        </Box>
        :
          <IconButton sx={{ mr: 1 }} color='inherit' size='large'>
            <AccountCircleIcon sx={{ scale: 1.5 }} />
          </IconButton>
        }
      </Toolbar>
    </AppBar>
  )
}
