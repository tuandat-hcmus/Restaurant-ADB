import {
  Alert,
  Box,
  Button,
  Card,
  Checkbox,
  Divider,
  FormControlLabel,
  Snackbar,
  TextField,
  Typography
} from '@mui/material'
import { AppContext } from 'src/contexts/AppContext'
import SetMealIcon from '@mui/icons-material/SetMeal'
import { useContext, useState } from 'react'
import authApi from '../../apis/AuthApi'
import { setTokenToLS, setRoleToLS } from '../../utils/auth'
import { jwtDecode } from 'jwt-decode'

export default function Login() {
  const { setIsAuth, isAuth, setRole } = useContext(AppContext)
  const [username, setUsername] = useState(null)
  const [password, setPassword] = useState(null)
  const [open, setOpen] = useState(false)
  const handleSubmit = (event) => {
    event.preventDefault()
    authApi
      .login({ username, password })
      .then((data) => {
        console.log(data)
        const { roles } = jwtDecode(data.token)
        setTokenToLS(data.token)
        setRoleToLS(roles)
        setRole(roles)
        setIsAuth(true)
      })
      .catch((error) => {
        console.log(error)
      })
      .finally(() => setOpen(true))
  }
  return (
    <Card sx={{ mx: 'auto', my: 6, p: 6, width: '25rem', display: 'flex', flexDirection: 'column', gap: 4 }}>
      <Box display={'flex'} gap={2} alignItems={'center'}>
        <SetMealIcon sx={{ scale: 1.5 }} color='primary' />
        <Typography variant='h6' color='primary' letterSpacing={2} fontWeight={700}>
          ShuShiX
        </Typography>
      </Box>
      <Box>
        <Typography variant='h4'>Log in</Typography>
        <Typography variant='body2'>Login to ShuShiX Restaurent as employee</Typography>
      </Box>
      <Box component={'form'} display={'flex'} flexDirection={'column'} gap={2} onSubmit={handleSubmit}>
        <TextField
          label='Username'
          variant='outlined'
          size='small'
          onChange={(event) => setUsername(event.target.value)}
          required
        />
        <TextField
          label='Password'
          variant='outlined'
          type='password'
          size='small'
          onChange={(event) => setPassword(event.target.value)}
          required
        />
        <FormControlLabel control={<Checkbox />} label='Remember me' />
        <Divider />
        <Button variant='contained' type='submit' fullWidth>
          Log in as employee
        </Button>
      </Box>
      <Snackbar
        open={open}
        autoHideDuration={3000}
        onClose={() => setOpen(false)}
        anchorOrigin={{ horizontal: 'center', vertical: 'bottom' }}
      >
        <Alert severity={isAuth ? 'success' : 'error'}>
          {isAuth ? 'Login successfully' : 'Invalid username or password'}
        </Alert>
      </Snackbar>
    </Card>
  )
}
