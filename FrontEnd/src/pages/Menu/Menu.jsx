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
  Divider,
  Stack,
  Snackbar,
  Alert
} from '@mui/material'
import SearchIcon from '@mui/icons-material/Search'
import { useContext, useEffect, useState } from 'react'
import menuApi from '../../apis/MenuApi'
import burger from '../../assets/burger.jpg'
import AddShoppingCartIcon from '@mui/icons-material/AddShoppingCart'
import { AppContext } from 'src/contexts/AppContext'
import userApi from '../../apis/UserApi'
import orderApi from '../../apis/OrderApi'

export default function Menu() {
  const { role } = useContext(AppContext)
  const [branchId, setBranchId] = useState('152OC76L7')
  const [menuList, setMenuList] = useState([])
  const [orderList, setOrderList] = useState([])
  const [tableNumber, setTableNumber] = useState(1)
  const [noti, setNoti] = useState({
    open: false, 
    message: false,
    success: false
  })
  const handleChange = (event) => setBranchId(event.target.value)
  const handleClick = () => {
    menuApi.getMenu(branchId).then((data) => {
      console.log(data)
      setOrderList([])
      setMenuList(data)
    })
  }
  const addToOrder = (item) => {
    setOrderList((prev) => {
      const existtingItem = prev.find((order) => order.maMon == item.id.maMonAn)
      if (existtingItem) {
        existtingItem.soLuong += 1
        return [...prev]
      }
      return [...prev, { maMon: item.id.maMonAn, soLuong: 1 }]
    })
  }
  const handleSubmit = (event) => {
    event.preventDefault()
    const userId = userApi.getUserId()
    orderApi
      .insertOrder({
        soBan: tableNumber,
        idNhanVien: userId,
        maChiNhanh: branchId,
        mon: orderList
      })
      .then((data) => {
        console.log(data)
        setNoti({
          open: true, 
          message: 'Create order successfully',
          success: true
        })
      })
      .catch((error) => {
        console.log(error)
        setNoti({
          open: true, 
          message: 'Failed to create order', 
          success: false
        })
      })
  }
  useEffect(() => {
    menuApi.getMenu(branchId).then((data) => {
      console.log(data)
      setMenuList(data)
    })
  }, [])
  useEffect(() => {
    userApi.getEmpInfo(userApi.getUserId()).then((info) => {
      setBranchId(info.maChiNhanh)
    }).catch(error => console.log(error))
  }, [])
  useEffect(() => {
    console.log(orderList)
  }, [orderList])
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
                    {role === 'employee' && (
                      <Button
                        variant='outlined'
                        color='secondary'
                        startIcon={<AddShoppingCartIcon />}
                        onClick={() => addToOrder(item)}
                      >
                        Add to order
                      </Button>
                    )}
                  </CardActions>
                </Card>
              </Grid2>
            ))}
          </Grid2>
        </Container>
        {role === 'employee' && (
          <Card sx={{ p: 2, minWidth: '15rem' }}>
            <Typography variant='h4'>Order</Typography>
            <Divider />
            <Box component='form' display={'flex'} flexDirection={'column'} gap={2} my={2} onSubmit={handleSubmit}>
              <TextField
                label='Table Number'
                type='number'
                variant='standard'
                size='small'
                defaultValue={tableNumber}
                onChange={(e) => setTableNumber(e.target.value)}
              />
              <Stack spacing={2}>
                {orderList.map((order) => (
                  <Box display={'flex'} justifyContent='space-between' key={order.maMon}>
                    <Typography variant='body1'>{order.maMon}</Typography>
                    <Typography variant='body1'>{order.soLuong}</Typography>
                  </Box>
                ))}
              </Stack>
              <Button type='submit' fullWidth variant='outlined'>
                Create
              </Button>
            </Box>
          </Card>
        )}
      </Box>
      <Snackbar
        open={noti.open}
        autoHideDuration={3000}
        onClose={() => setNoti({open: false, message: false, success: false})}
        anchorOrigin={{ horizontal: 'right', vertical: 'bottom' }}
      >
        <Alert severity={noti.success ? 'success' : 'error'}>
          {noti.message}
        </Alert>
      </Snackbar>
    </div>
  )
}
