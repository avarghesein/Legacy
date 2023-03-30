
using System;
using System.Collections; 

namespace XCoDec
{
	internal class CPerm : IEnumerable,IEnumerator  
	{
		private int m_Count;

		public CPerm(int Count) 
		{
			m_Count = Count;  
		}

		private System.Collections.ArrayList GetPerm(ArrayList List)
		{
			ArrayList retList = new ArrayList();

			if(List.Count <= 1) 
			{
				retList.Add(new ArrayList());
				(retList[0] as ArrayList).Add(List[0]);  
				return retList;
			}
  
			for(int i = 0; i < List.Count; ++i)
			{
				ArrayList subList = new ArrayList();
				ArrayList newList; 
  
				for(int j=0; j < List.Count; ++j)
					if(List[i] != List[j]) subList.Add(List[j]);

				foreach(ArrayList subRetList in GetPerm(subList))
				{
					(newList = new ArrayList()).Add(List[i]);
					newList.AddRange(subRetList);
					retList.Add(newList);
				} 
			}
			return retList; 
		}

		#region Implementation of IEnumerable

		System.Collections.IEnumerator IEnumerable.GetEnumerator()
		{
			(this as IEnumerator).Reset(); 
			return this;
		}

		#endregion

		#region Implementation of IEnumerator

		private ArrayList m_List;

		void IEnumerator.Reset()
		{
			ArrayList tmpList = new ArrayList();
			for(int i = 0; i < m_Count; ++i) tmpList.Add(i);
			m_List = GetPerm(tmpList);  
		}

		bool IEnumerator.MoveNext()
		{
			return m_List.Count > 0;
		}

		object IEnumerator.Current
		{
			get
			{
				ArrayList ret = m_List[0] as ArrayList; 
				m_List.RemoveAt(0);  
				return ret;
			}
		}

		#endregion
	};
};