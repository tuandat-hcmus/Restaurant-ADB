import { AppBar, Box, Button, IconButton, Toolbar, Typography } from '@mui/material'
import SetMealIcon from '@mui/icons-material/SetMeal'

export default function TopBar() {
  return (
    <AppBar position='relative' sx={{ flexGrow: 1 }}>
      <Toolbar>
        <IconButton sx={{ mr: 1 }} color='inherit' size='large'>
          <SetMealIcon />
        </IconButton>
        <Typography variant='h6' component='div' sx={{ flexGrow: 1 }}>
          <Box sx={{fontWeight: 700}}>ShuShiX</Box>
        </Typography>
        <Box>
          <Button color='inherit' sx={{ mr: 2 }}>
            Log in as Guest
          </Button>
          <Button variant='outlined' color='white'>
            Log in as Employee
          </Button>
        </Box>
      </Toolbar>
    </AppBar>
  )
}
