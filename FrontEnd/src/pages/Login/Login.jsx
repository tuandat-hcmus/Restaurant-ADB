import { Box, Button, Card, Checkbox, Divider, FormControlLabel, TextField, Typography } from '@mui/material'
import SetMealIcon from '@mui/icons-material/SetMeal'

export default function Login() {
  return (
    <Card sx={{ mx: 'auto', my: 6, p: 4, width: '25rem', display: 'flex', flexDirection: 'column', gap: 4 }}>
      <Box display={'flex'} gap={2} alignItems={'center'}>
        <SetMealIcon sx={{ scale: 1.5 }} color='primary' />
        <Typography variant='h6' color='primary' letterSpacing={2} fontWeight={700}>
          ShuShiX
        </Typography>
      </Box>
      <Typography variant='h4'>Log in</Typography>
      <Box component={'form'} display={'flex'} flexDirection={'column'} gap={2}>
        <TextField label='Username' variant='outlined' />
        <TextField label='Password' variant='outlined' type='password' />
        <FormControlLabel control={<Checkbox  />} label='Remember me' />
        <Divider />
        <Button variant='contained'>Log in</Button>
      </Box>
    </Card>
  )
}
