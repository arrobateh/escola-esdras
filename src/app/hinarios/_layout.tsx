import { Stack } from 'expo-router';
import { CatalogProvider } from '../../features/hymnals/CatalogProvider';

export default function HymnalsLayout() {
  return <CatalogProvider><Stack screenOptions={{ headerShown: false }} /></CatalogProvider>;
}
