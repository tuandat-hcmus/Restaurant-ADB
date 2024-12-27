import { Box, Button, Card, Checkbox, Divider, FormControlLabel, TextField, Typography } from '@mui/material'
import { AppContext } from 'src/contexts/AppContext'
import SetMealIcon from '@mui/icons-material/SetMeal'
import { useContext, useState } from 'react'
import { http } from 'src/utils/http'

export default function Login() {
  const { setIsAuthenticated } = useContext(AppContext)
  const [username, setUsername] = useState(null)
  const [password, setPassword] = useState(null)
  const handleSubmit = (event) => {
    event.preventDefault()
    http
      .post('/login', {
        username,
        password
      })
      .then((data) => {
        console.log(data)
        setIsAuthenticated(true)
      })
      .catch((error) => {
        console.log(error)
      })
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
        <Typography variant='body2'>Login to ShuShiX Restaurent</Typography>
      </Box>
      <Box component={'form'} display={'flex'} flexDirection={'column'} gap={2} onSubmit={handleSubmit}>
        <TextField
          label='Username'
          variant='outlined'
          size='small'
          onChange={(event) => setUsername(event.target.value)}
        />
        <TextField
          label='Password'
          variant='outlined'
          type='password'
          size='small'
          onChange={(event) => setPassword(event.target.value)}
        />
        <FormControlLabel control={<Checkbox />} label='Remember me' />
        <Divider />
        <Button variant='contained' type='submit' fullWidth>
          Log in
        </Button>
      </Box>
    </Card>
  )
}
