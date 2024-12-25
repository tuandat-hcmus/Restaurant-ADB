import { AppBar, Toolbar, Typography } from '@mui/material'
import SetMealIcon from '@mui/icons-material/SetMeal';

export default function TopBar() {
  return (
    <AppBar position='relative'>
      <Toolbar>
        <SetMealIcon sx={{ mr: 2}}/>
        <Typography variant='h6'>SuShiX</Typography>
      </Toolbar>
    </AppBar>
  )
}
