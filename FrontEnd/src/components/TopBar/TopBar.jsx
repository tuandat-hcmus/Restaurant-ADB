import { AppBar, Box, Button, IconButton, Toolbar, Typography } from '@mui/material'
import SetMealIcon from '@mui/icons-material/SetMeal'
import AccountCircleIcon from '@mui/icons-material/AccountCircle'

export default function TopBar({ auth }) {
  return (
    <AppBar position='relative' sx={{ flexGrow: 1 }}>
      <Toolbar>
        <IconButton sx={{ mr: 1 }} color='inherit' size='large'>
          <SetMealIcon sx={{ scale: 1.5 }} />
        </IconButton>
        <Typography variant='h6' component='div' sx={{ flexGrow: 1, letterSpacing: 2 }}>
          <Box sx={{ fontWeight: 700 }}>ShuShiX</Box>
        </Typography>
        {!auth && <Button color='inherit'>Log in</Button>}
        {auth && (
          <IconButton sx={{ mr: 1 }} color='inherit' size='large'>
            <AccountCircleIcon sx={{ scale: 1.5 }} />
          </IconButton>
        )}
      </Toolbar>
    </AppBar>
  )
}
