import { Box, Button, TextField, Typography } from '@mui/material'
import SearchIcon from '@mui/icons-material/Search'
import { useState } from 'react'
import menuApi from 'src/apis/MenuApi'

export default function Menu() {
  const [branchId, setBranchId] = useState('152OC76L7')
  const handleChange = (event) => setBranchId(event.target.value)
  const handleClick = () => {
    menuApi.getMenu(branchId)
  }
  return (
    <div>
      <Typography variant='h4' gutterBottom>
        Home Page | ShuShiX
      </Typography>
      <Box display={'flex'} alignItems={'center'} justifyContent={'right'} gap={2}>
        <Typography variant='body1'>Select branch Id: </Typography>
        <Box display={'flex'} alignContent={'center'}>
          <TextField
            size='small'
            label='Branch id'
            variant='outlined'
            color='inherit'
            defaultValue={branchId}
            onChange={handleChange}
          />
          <Button variant='outlined' onClick={handleClick}>
            <SearchIcon />
          </Button>
        </Box>
      </Box>
    </div>
  )
}
