import { useContext } from 'react'
import { AppContext } from './contexts/AppContext'
import { Navigate, Outlet, useRoutes } from 'react-router-dom'
import Login from './pages/Login'
import Home from './pages/Home'
import CusLogin from './pages/CusLogin'
import Dashboard from './pages/Dashboard/Dashboard'
import MainLayout from './layouts/MainLayout/MainLayout'

function RejectedRoute() {
  const {isAuth} = useContext(AppContext)
  return !isAuth? <Outlet /> : <Navigate to='/' />
}

function Root() {
  const {isAuth, role} = useContext(AppContext)
  if(!isAuth) 
    return <MainLayout />
  return role === 'employee'? <Dashboard /> : <Home />
}

export default function useRouteElements() {
  const elements = useRoutes([
    {
      path: '', 
      element: <Root />
    },
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
    }
  ])
  return elements
}
