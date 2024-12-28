import {
  Box,
  Button,
  Card,
  Checkbox,
  Divider,
  FormControlLabel,
  TextField,
  Typography,
  Snackbar,
  Alert
} from '@mui/material'
import { AppContext } from 'src/contexts/AppContext'
import SetMealIcon from '@mui/icons-material/SetMeal'
import { useContext, useState } from 'react'
import authApi from '../../apis/AuthApi'
import { setTokenToLS } from '../../utils/auth'

export default function CusLogin() {
  const { setIsCusAuth, isCusAuth } = useContext(AppContext)
  const [username, setUsername] = useState(null)
  const [password, setPassword] = useState(null)
  const [open, setOpen] = useState(false)
  const handleSubmit = (event) => {
    event.preventDefault()
    authApi
      .cusLogin({ username, password })
      .then((data) => {
        console.log(data)
        setTokenToLS(data.token)
        setIsCusAuth(true)
      })
      .catch((error) => {
        console.log(error)
      })
      .finally(() => setOpen(true))
  }
  return (
    <Card sx={{ mx: 'auto', my: 6, p: 6, width: '25rem', display: 'flex', flexDirection: 'column', gap: 4 }}>
      <Box display={'flex'} gap={2} alignItems={'center'}>
        <SetMealIcon sx={{ scale: 1.5 }} color='secondary' />
        <Typography variant='h6' color='secondary' letterSpacing={2} fontWeight={700}>
          ShuShiX
        </Typography>
      </Box>
      <Box>
        <Typography variant='h4'>Log in</Typography>
        <Typography variant='body2'>Login to ShuShiX Restaurent as customer</Typography>
      </Box>
      <Box component={'form'} display={'flex'} flexDirection={'column'} gap={2} onSubmit={handleSubmit}>
        <TextField
          label='Username'
          variant='outlined'
          size='small'
          onChange={(event) => setUsername(event.target.value)}
          color='secondary'
          required
        />
        <TextField
          label='Password'
          variant='outlined'
          type='password'
          size='small'
          onChange={(event) => setPassword(event.target.value)}
          color='secondary'
          required
        />
        <FormControlLabel control={<Checkbox color='secondary' />} label='Remember me' />
        <Divider />
        <Button variant='contained' type='submit' fullWidth color='secondary'>
          Log in as customer
        </Button>
      </Box>
      <Snackbar
        open={open}
        autoHideDuration={3000}
        onClose={() => setOpen(false)}
        anchorOrigin={{ horizontal: 'center', vertical: 'bottom' }}
      >
        <Alert severity={isCusAuth ? 'success' : 'error'}>
          {isCusAuth ? 'Login successfully' : 'Invalid username or password'}
        </Alert>
      </Snackbar>
    </Card>
  )
}
