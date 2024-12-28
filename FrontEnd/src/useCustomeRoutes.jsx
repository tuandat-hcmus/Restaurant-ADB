import { useContext } from 'react'
import { AppContext } from './contexts/AppContext'
import { Navigate, Outlet, useRoutes } from 'react-router-dom'
import Login from './pages/Login'
import Home from './pages/Home'
import CusLogin from './pages/CusLogin'

function RejectedEmpRoute() {
  const { isAuth } = useContext(AppContext)
  return !isAuth ? <Outlet /> : <Navigate to='/' replace />
}

function RejectedCusRoute() {
  const { isCusAuth } = useContext(AppContext)
  return !isCusAuth ? <Outlet /> : <Navigate to='/' />
}

export default function useRouteElements() {
  const elements = useRoutes([
    {
      path: '/',
      element: <Home />
    },
    {
      path: '',
      element: <RejectedEmpRoute />,
      children: [
        {
          path: '/login',
          element: <Login />
        }
      ]
    },
    {
      path: '',
      element: <RejectedCusRoute />,
      children: [
        {
          path: '/cusLogin',
          element: <CusLogin />
        }
      ]
    }
  ])
  return elements
}
