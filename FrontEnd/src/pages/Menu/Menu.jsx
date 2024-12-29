import {
  Box,
  Button,
  Card,
  CardContent,
  CardMedia,
  Container,
  Grid2,
  TextField,
  Typography,
  CardActions,
  Divider
} from '@mui/material'
import SearchIcon from '@mui/icons-material/Search'
import { useContext, useEffect, useState } from 'react'
import menuApi from '../../apis/MenuApi'
import burger from '../../assets/burger.jpg'
import AddShoppingCartIcon from '@mui/icons-material/AddShoppingCart'
import { AppContext } from 'src/contexts/AppContext'

export default function Menu() {
  const { role } = useContext(AppContext)
  const [branchId, setBranchId] = useState('152OC76L7')
  const [menuList, setMenuList] = useState([])
  const [orderList, setOrderList] = useState([])
  const handleChange = (event) => setBranchId(event.target.value)
  const handleClick = () => {
    menuApi.getMenu(branchId).then((data) => {
      console.log(data)
      setMenuList(data)
    })
  }
  useEffect(() => {
    menuApi.getMenu(branchId).then((data) => {
      console.log(data)
      setMenuList(data)
    })
  }, [])
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
      <Box display={'flex'} gap={2} mt={4} alignItems={'flex-start'}>
        <Container>
          <Grid2 container spacing={4} justifyContent={'center'}>
            {menuList?.map((item) => (
              <Grid2 key={JSON.stringify(item.id)} size={{ xs: 12, sm: 6, md: 4 }}>
                <Card>
                  <CardMedia image={burger} sx={{ paddingTop: '56.25%' }} />
                  <CardContent>
                    <Typography variant='h5' gutterBottom>
                      {item.tenMon}
                    </Typography>
                    <Typography variant='body1' gutterBottom color='textSecondary'>
                      Category: {item.tenMuc}
                    </Typography>
                    <Typography variant='body2' gutterBottom>
                      Price: {item.donGia} VND
                    </Typography>
                  </CardContent>
                  <CardActions>
                    <Button variant='outlined' color='secondary' startIcon={<AddShoppingCartIcon />}>
                      Add to order
                    </Button>
                  </CardActions>
                </Card>
              </Grid2>
            ))}
          </Grid2>
        </Container>
        {role === 'employee' && <Card sx={{ p: 2 }}>
          <Typography variant='h4'>Order</Typography>
          <Divider />
          <Box component='form' display={'flex'} flexDirection={'column'} gap={2} my={2}>
            <TextField label='Table Number' type='number' variant='standard' size='small'/>
          </Box>
        </Card>}
      </Box>
    </div>
  )
}
