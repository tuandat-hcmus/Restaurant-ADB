import { useContext } from 'react'
import { AppContext } from './contexts/AppContext'
import { Navigate, Outlet, useRoutes } from 'react-router-dom'
import Login from './pages/Login'
// import Home from './pages/Home'
import CusLogin from './pages/CusLogin'
// import Dashboard from './pages/Dashboard'
import MainLayout from './layouts/MainLayout'
import Menu from './pages/Menu'
import MainEmpLayout from './layouts/MainEmpLayout/MainEmpLayout'

function RejectedRoute() {
  const { isAuth } = useContext(AppContext)
  return !isAuth ? <Outlet /> : <Navigate to='/' />
}

function Root() {
  const { isAuth, role } = useContext(AppContext)
  if (!isAuth || role === 'customer') return <MainLayout />
  return <MainEmpLayout />
}

export default function useRouteElements() {
  const elements = useRoutes([
    {
      path: '',
      element: <RejectedRoute />,
      children: [
        {
          path: '/login',
          element: <Login />
        },
        {
          path: '/cusLogin',
          element: <CusLogin />
        }
      ]
    }, 
    {
      path: '',
      element: <Root />, 
      children: [
        {
          path: '',
          index: true,
          element: <Menu />
        }
      ]
    },
  ])
  return elements
}
